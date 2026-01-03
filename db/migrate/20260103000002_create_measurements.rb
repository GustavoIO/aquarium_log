class CreateMeasurements < ActiveRecord::Migration[7.1]
  def change
    create_table :measurements do |t|
      t.references :aquarium, null: false, foreign_key: true
      t.decimal :ph, precision: 4, scale: 2
      t.decimal :kh, precision: 5, scale: 2
      t.decimal :gh, precision: 5, scale: 2
      t.decimal :nitrates, precision: 6, scale: 2
      t.decimal :phosphates, precision: 5, scale: 3
      t.datetime :measured_at, null: false

      t.timestamps
    end

    add_index :measurements, [:aquarium_id, :measured_at]
  end
end
