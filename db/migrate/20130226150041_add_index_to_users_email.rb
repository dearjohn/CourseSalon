class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	#这里从数据库层面对唯一性验证，需要加索引
  	add_index :users, :email, unique: true
  end
end
