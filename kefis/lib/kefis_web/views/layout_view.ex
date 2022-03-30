defmodule KefisWeb.LayoutView do
  use KefisWeb, :view
  alias Phoenix.Controller

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def askj(meme) do
    case meme do
      1 ->
        " <script>
        document.addEventListener('readystatechange', event => {
            if (event.target.readyState === 'complete') {
                  //window.display_modal('');
            }
        });

          </script>"
      2 ->
        "2"
      _ ->
        "sdkj"
    end

  end


  def flasher(flash) do
    case flash do
      %{"info" => info } ->
        raw "<script>
         document.addEventListener('readystatechange', event => {
           if (event.target.readyState === 'complete') {

          window.display_modal({icon: 'success', title: 'Error', message: '#{info}'});
           }
         });
         </script>"

      %{"error" => error } ->
          raw "<script>
          console.log('error');
         document.addEventListener('readystatechange', event => {
           if(event.target.readyState === 'complete') {


          window.display_modal({icon: 'error', title: 'Error', message: '#{error}'});

           }
         });
         </script>"
      _ ->
         ""
    end
  end
end
