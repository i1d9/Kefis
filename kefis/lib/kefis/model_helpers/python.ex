defmodule Kefis.Python do
  @moduledoc false


  @doc """
  Initate Python instance that calls a specified python file
  """
  def py_instance(path) when is_binary(path) do

    {:ok, pid}= :python.start(python_path: 'lib/kefis/model',python: '/usr/bin/python3.8')


    pid

  end

  @doc """
  Makes a synchronous call to the modules function with arguments if specificed
  """
  def py_call(pid, module, func, args \\ []) do
    pid
    |> :python.call(module, func, args)
  end

  @doc """
  Terminates the python instance
  """
  def py_stop(pid) do
    :python.stop(pid)
  end
end
