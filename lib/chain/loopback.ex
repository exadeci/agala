defmodule Agala.Chain.Loopback do
  @moduledoc """
  Loopback automaticly sends response back to the bot, which got the request

  You can use this Chain in pipeline in order to simplify resolving name of
  the bot, that should response with your connections.

  ### Example:
      defmodule SimpleHandler
        chain Agala.Chain.Loopback
        chain :handle

        def handle(conn, _opts) do
          # Here, responser already the same, as receiver
          assert conn.responser == conn.request_bot_params.bot
        end
      end
  """
  import Agala.Conn

  @doc false
  def init(opts), do: opts

  @doc false
  @spec call(conn :: Agala.Conn.t, opts :: any) :: Agala.Conn.t
  def call(conn = %Agala.Conn{request_bot_params: %{bot: bot}}, _opts) do
    send_to(conn, bot)
  end
end
