class Task < ApplicationRecord
    CATEGORIES_BY_GROUP = {
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

    CATEGORIES = CATEGORIES_BY_GROUP.values.flatten
  
    validates :category, inclusion: { in: CATEGORIES }
    validates :color, inclusion: { in: COLORS }
end