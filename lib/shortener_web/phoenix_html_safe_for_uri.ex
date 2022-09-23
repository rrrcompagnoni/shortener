defimpl Phoenix.HTML.Safe, for: URI do
  def to_iodata(value), do: ShortenerWeb.AliasView.uri_to_string(value)
end
