class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	#处理用户密码
    add_column :users, :password_digest, :string
  end
end
