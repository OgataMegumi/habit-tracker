module ApplicationHelper
  def task_category_image_map
    {
      "ランニング" => "running.png",
      "ウォーキング" => "walking.png",
      "筋トレ" => "training.png",
      "ストレッチ" => "stretch.png",
      "ヨガ" => "yoga.png",
      "これ以外の運動" => "other_exercise.png",
      "貯金" => "saving.png",
      "投資" => "investment.png",
      "プログラミング" => "programming.png",
      "語学" => "language_study.png",
      "英会話" => "english_conversation.png",
      "タスク管理" => "task_management.png",
      "スキルアップ" => "skill_up.png",
      "副業" => "side_job.png",
      "メンタルケア" => "mental_care.png",
      "睡眠" => "sleep.png",
      "バランスのいい食事" => "balanced_diet.png",
      "自炊" => "cooking.png",
      "糖質制限" => "low_carb.png",
      "ダイエット" => "diet.png",
      "音楽" => "music.png",
      "執筆" => "writing.png",
      "写真" => "photography.png",
      "アウトドア" => "outdoor.png",
      "ボランティア" => "volunteer.png",
      "イベント参加" => "event.png",
      "交流" => "socializing.png",
      "読書" => "reading.png",
      "日記" => "diary.png",
      "部屋の片付け" => "cleaning.png",
      "断捨離" => "decluttering.png",
      "デジタルデトックス" => "digital_detox.png",
      "どれとも違う素敵なカテゴリ" => "other.png"
    }
  end

  def hide_header_for_devise_page?
    hidden_devise_pages = [
      { controller: "sessions", action: "new" },
      { controller: "registrations", action: "new" },
      { controller: "passwords", action: "new" },
      { controller: "users", action: "index" }
    ]

    hidden_devise_pages.any? do |page|
      controller_name == page[:controller] && action_name == page[:action]
    end
  end
end
