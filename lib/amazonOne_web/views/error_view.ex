defmodule AmazonOneWeb.ErrorView do
  use AmazonOneWeb, :view
  require Logger
  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  # def template_not_found(template, _assigns) do
  #   Phoenix.Controller.status_message_from_template(template)
  # end

  def render("error.json", %{changeset: changeset}) do
    render_one(changeset, AmazonOneWeb.ErrorView, "errors.json", as: :errors)
  end

  def render("error_message.json", %{message: message}) do
    %{errors: %{detail: message}}
  end


  def render("errors.json", %{ errors: errors}) do
    %{error: %{errors: translate_errors(errors)}}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end
