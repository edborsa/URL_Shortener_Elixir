defmodule URLShortenerWeb.ExportController do
  use URLShortenerWeb, :controller

  action_fallback URLShortnerWeb.FallbackController

  def create(conn, _params) do
    fields = [:short_url, :long_url, :visited]
    csv_data = csv_content(URLShortener.URLStore.list_mapped_urls(), fields)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"export.csv\"")
    |> put_root_layout(false)
    |> send_resp(200, csv_data)
  end

  defp csv_content(records, fields) do
    ([create_header(fields)] ++
       Enum.map(records, fn record ->
         %{record | short_url: System.get_env("HOST_NAME") <> record.short_url}
       end))
    |> Enum.map(fn
      record when is_struct(record) ->
        record
        |> Map.from_struct()
        # gives an empty map
        |> Map.take([])
        |> Map.merge(Map.take(record, fields))
        |> Map.values()

      record ->
        record
        # gives an empty map
        |> Map.take([])
        |> Map.merge(Map.take(record, fields))
        |> Map.values()
    end)
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end

  defp create_header(fields) do
    fields
    |> Enum.reduce(%{}, fn field, acc ->
      Map.put(acc, field, Atom.to_string(field))
    end)
  end
end
