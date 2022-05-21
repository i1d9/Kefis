defmodule Kefis.ModelPredictor do
  alias Kefis.Python, as: Helper

  @path 'lib/kefis/model'

  def predict(args) do
    call_python(:predictor, :predict_model, args)
  end

  defp call_python(module, func, args) do
    pid = Helper.py_instance(Path.absname(@path))
    result = Helper.py_call(pid, module, func, args)

    pid
    |> Helper.py_stop()

    result
  end
end
