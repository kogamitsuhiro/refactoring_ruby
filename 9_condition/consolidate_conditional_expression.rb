# 9.3 条件式の統合

# 前
def disability_amout
  return 0 if @seniority < 2
  return 0 if @months_disbaled > 12
  return 0 if @is_part_time

  # 傷病手当金の計算
  # ...
end

# リファクタリング後
def disability_amout
  return 0 if ineligible_for_disability?

  # 傷病手当金の計算
  # ...
end

def ineligible_for_disability? #傷病手当金無資格者か?
  @seniority < 2 || @months_disbaled > 12 || @is_part_time
end

# ポイント
# 条件は違うけど返す結果が同じ場合、一つの条件式にまとめてメソッド抽出する。

# ただし、以下の場合は避ける
# チェックが独立しており、一つの条件式にまとめると逆にプログラマの意図と反してしまう場合。
# 副作用がある場合。
