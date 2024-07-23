defmodule DemoWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use DemoWeb, :controller` and
  `use DemoWeb, :live_view`.
  """
  use DemoWeb, :html

  embed_templates "layouts/app.html"
  embed_templates "layouts/root.html"

end
