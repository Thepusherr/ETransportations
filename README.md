# README

This README would normally document whatever steps are necessary to get the
application up and running.

commands to start server:
bundle install
rails db:create
rails db:migrate
rails s

command to run tests:
rpsec

curl requests:
curl -X POST http://localhost:3000/api/v1/e_transportations -d '{"e_transportation": {"e_transportation_type": "e-bike", "sensor_type": "small", "owner_id": 1, "in_zone": false, "lost_sensor": false}}' -H "Content-Type: application/json"
curl -X POST http://localhost:3000/api/v1/e_transportations -d '{"e_transportation": {"e_transportation_type": "e-scooter", "sensor_type": "big", "owner_id": 2, "in_zone": false, "lost_sensor": false}}' -H "Content-Type: application/json"
curl http://localhost:3000/api/v1/e_transportations/out_of_zone