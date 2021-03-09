class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :accounts, id: :uuid, comment: 'アカウント' do |t|
      t.string :username, null: false, comment: 'ユーザー名'
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :avatar_url, null: true, comment: 'アバターURL'
      t.string :password_digest, comment: 'ハッシュ化されたパスワード'

      t.timestamps
    end
    add_index :accounts, :email, unique: true
  end
end
