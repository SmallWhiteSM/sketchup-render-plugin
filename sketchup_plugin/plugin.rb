require 'json'

module SimpleRenderPlugin

  PLUGIN_NAME = "Simple Render Plugin"

  # 主功能：匯出模型為 JSON
  def self.export_model
    model = Sketchup.active_model
    entities = model.entities

    data = {
      faces: []
    }

    entities.grep(Sketchup::Face).each do |face|
      vertices = face.vertices.map { |v|
        [
          v.position.x.to_f,
          v.position.y.to_f,
          v.position.z.to_f
        ]
      }      

      material = face.material ? face.material.display_name : "default"

      data[:faces] << {
        vertices: vertices,
        material: material
      }
    end

    # 存檔位置（建議改成你的實際儲存路徑）
    path = File.join("C:\\Users\\...\\Desktop", "sketchup_model.json")

    File.open(path, "w") do |file|
      file.write(JSON.pretty_generate(data))
    end

    UI.messagebox("模型已匯出到：#{path}")

    # 呼叫 Python renderer（可選）
    run_renderer(path)
  end

  def self.run_renderer(json_path)
    # 取得 render.py 的絕對路徑
    script_path = File.join(File.dirname(__FILE__), "render.py")

    # Python（建議改成你的實際路徑）
    python_exe = "C:\\Users\\...\\python.exe"

    cmd = "\"#{python_exe}\" \"#{script_path}\" \"#{json_path}\""

    puts "Running: #{cmd}"

    result = system(cmd)

    if result
      # Python 成功後再開圖
      output_path = json_path.gsub(".json", ".png")

      UI.messagebox("Render 完成，準備打開圖片")

      if File.exist?(output_path)
        UI.messagebox("圖片存在 \n#{output_path}")
      else
        UI.messagebox("圖片不存在 \n#{output_path}")
      end

      UI.openURL("file:///#{output_path.gsub('\\', '/')}")
    else
      UI.messagebox("Render 失敗")
    end

  end

  # UI 初始化
  def self.create_toolbar
    toolbar = UI::Toolbar.new PLUGIN_NAME

    cmd = UI::Command.new("Export Render") {
      self.export_model
    }

    cmd.tooltip = "Export model and render"
    cmd.status_bar_text = "Export model to JSON and call renderer"

    # 這裡可以放 icon（可選）
    # cmd.small_icon = "icon.png"
    # cmd.large_icon = "icon.png"

    toolbar.add_item cmd
    toolbar.show
  end

  unless file_loaded?(__FILE__)
    self.create_toolbar
    file_loaded(__FILE__)
  end

end