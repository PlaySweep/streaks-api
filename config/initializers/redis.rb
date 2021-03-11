require 'connection_pool'
require 'competition_ranking_leaderboard'

redis_options = { redis_connection: Redis.new(url: ENV["REDIS_URL"]) }
STREAK_LEADERBOARD = CompetitionRankingLeaderboard.new('streak_leaderboard', Leaderboard::DEFAULT_OPTIONS, redis_options)
POINTS_LEADERBOARD = Leaderboard.new('points_leaderboard',  Leaderboard::DEFAULT_OPTIONS, redis_options)

Redis.current = Redis.new(url: ENV["REDIS_URL"])
Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) { Redis.new(url: ENV["REDIS_URL"]) }
