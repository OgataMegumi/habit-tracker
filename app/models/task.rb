class Task < ApplicationRecord
    has_many :task_logs, dependent: :destroy

    FREQUENCY_RANGE = (1..12).to_a
    FREQUENCY_UNITS_LIST = ["時間", "日", "週", "ヶ月"]
    CATEGORIES_GROUPS = {
        "運動" => ["ランニング", "ウォーキング", "筋トレ", "ストレッチ", "ヨガ", "これ以外"],
        "金融" => ["貯金", "投資"],
        "学習" => ["プログラミング", "語学", "英会話"],
        "キャリア" => ["タスク管理", "スキルアップ", "副業"],
        "健康" => ["メンタルケア", "睡眠", "バランスのいい食事", "自炊", "糖質制限", "ダイエット"],
        "趣味" => ["音楽", "執筆", "写真", "アウトドア"],
        "社会活動" => ["ボランティア", "イベント参加", "交流"],
        "ライフログ" => ["読書", "日記"],
        "生活" => ["部屋の片付け", "断捨離", "デジタルデトックス"],
        "その他" => ["どれとも違う素敵なカテゴリ"]
    }
    COLORS = ["赤", "青", "緑", "黄", "紫"]
    CATEGORIES = CATEGORIES_GROUPS.values.flatten
  
    validates :frequency_number, inclusion: { in: FREQUENCY_RANGE }
    validates :frequency_unit, inclusion: { in: FREQUENCY_UNITS_LIST }
    validates :category, inclusion: { in: CATEGORIES }
    validates :color, inclusion: { in: COLORS }

    def toggle_execution!(data)
        log = task_logs.find_by(executed_on: data)
        if log
            log.destroy
        else
            task_logs.create!(executed_on: data)
        end
    end

    def total_days
        (end_date - start_date).to_i + 1
    end

    def executed_days
        task_logs.where(executed_on: start_date..end_date).distinct.count(:executed_on)
    end

    def progress_percentage
        return 0 if total_days.zero?
        (executed_days.to_f / total_days * 100).round(1)
    end

    def self.dates_in_current_month
        start_date = Date.today.beginning_of_month
        end_date = Date.today.end_of_month
        (start_date..end_date).to_a
    end
end