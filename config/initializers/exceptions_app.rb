# Rails.application.config.exceptions_app = ->(env) do
#   # actionメソッドでProcオブジェクトを返す
#   ErrorsController.action(:show).call(env)
# end