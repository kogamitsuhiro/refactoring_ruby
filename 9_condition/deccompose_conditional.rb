# 9.1 条件分の分解

# 前
if date < SUMMER_START || date > SUMMER_END
  charge = quantity * @winter_rate + @winter_service_charge
else
  charge = quantity * @summer_rate
end

# リファクタリング後
if not_summer(date)
  charge = winter_charge(quantity)
else
  charge = summer_charge(quantity)
end

def not_summer(date)
  date < SUMMER_START || date > SUMMER_END
end

def winter_charte(qunatity)
  quantity * @winter_rate + @winter_service_charge
end

def summer_charge(quantity)
  quantity * @summer_rate
end

# ポイント
# 条件部分をメソッドにする。thenとelseからメソッドを抽出する。
# 
# リファクタリング後は、条件部分が強調されるので、なぜその分岐なのか理由がはっきりしやすい。
# 分岐のロジックと分岐後の処理が分離出来ている。

# これくらい短い条件の場合はメソッドに抽出しないエンジニアが多い。
# しかし、not_summer の方がコメントに近くて意図が明確になる。