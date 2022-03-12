# 6.12 サンドイッチメソッドの抽出

## 改修前
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descedants
    children.inject(0) do |count, child|
      count += 1 if child.alive?
      count + child.number_of_living_descedants
    end
  end

  def number_of_descedants_named(name)
    children.inject(0) do |count, child|
      count += 1 if child.name == name
      count + child.number_of_living_descedants_named(name)
    end
  end

  def alive?
    @date_of_death.nil?
  end
end

## 改修後
class Person
  attr_reader :mother, :children, :name

  def initialize(name, date_of_birth, date_of_death=nil, mother=nil)
    @name, @mother = name, mother
    @date_of_birth, @date_of_death = date_of_birth, date_of_death
    @children = []
    @mother.add_child(self) if @mother
  end

  def add_child(child)
    @children << child
  end

  def number_of_living_descedants
    count_descedants_mathing { |descedant| descedant.alive? }
  end

  def number_of_descedants_named(name)
    count_descedants_mathing { |descedant| descedant.name == name }
  end

  def alive?
    @date_of_death.nil?
  end

  protected

  def count_descedants_mathing(&block)
    children.inject(0) do |count, child|
      count += 1 if yield child
      count + child.count_descedants_mathing(name)
    end
  end
end

## ポイント
# 重複部分を抽出して、ブロック付きメソッドにする。
# yieldで呼び出し元に制御が一度返ってくる。
# 返ってきた時の制御(ロジック)をブロックに記述する。
# →これにより、
# ・publicメソッドにロジックがあり、視認性が高い
# ・重要なロジック以外の重複している処理を後ろに隠せる。分離できる。
# 例で言うと反復処理をしていること自体は重要ではない。条件による数を返すことの方が重要。
