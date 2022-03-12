# 6.17 動的メソッド定義

## 訂正前
def failure
  self.state = :failure
end

def error
  self.state = :error
end

def success
  self.state = :success
end


## 訂正後
### def_each
def_each :failure, :error do |method_name|
  self.state = method_name
end

### define_method
[:failure, :error].each do |method|
  define_method method do
    self.state = method
  end
end

### クラスアノテーション(注釈)
### :クラスの状態設定メソッドとして表現が上がる
class Post
  def self.state(*args)
    args.each do |arg|
      define_method arg do 
        self.state = arg
      end
    end
  end

  state :failure, :error, :success
end
