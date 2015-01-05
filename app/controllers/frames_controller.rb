class FramesController < ApplicationController

  def update
    frame = Frame.find(params[:id])

    frame.update(frame_params)

    match = Match.find(params[:match_id])

    match.player_1_frames = 0
    match.player_2_frames = 0

    match.frames.each do |frame|
      if frame.player_1_points > frame.player_2_points
        match.player_1_frames += 1
      elsif frame.player_1_points < frame.player_2_points
        match.player_2_frames += 1
      end
    end

    match.save

    league = League.find(params[:league_id])

    update_tables(league, match.player_1)
    update_tables(league, match.player_2)

    update_positions(league)

    render :json => match.to_json(:only => [:player_1_frames, :player_2_frames])
  end

  private
    def frame_params
      params.require(:frame).permit(:id, :player_1_points, :player_2_points)
    end

    def update_tables(league, player)

      table = league.tables.find_by(player_id: player.id)


      table.position = 0
      table.number_of_matches = 0
      table.points = 0
      table.number_of_wins = 0
      table.number_of_loss = 0
      table.number_of_win_frames = 0
      table.number_of_lose_frames = 0
      table.number_of_win_small_points = 0
      table.number_of_lose_small_points = 0

      league.rounds.each do |round|
        round.matches.where(player_1_id: player.id).each do |match|

          if match.player_1_frames > match.player_2_frames
            table.number_of_matches += 1
            table.number_of_wins += 1
            table.points += league.win_points
          elsif match.player_2_frames > match.player_1_frames
            table.number_of_matches += 1
            table.number_of_loss += 1
            table.points += league.loss_points
          end

          match.frames.each do |frame|
            if frame.player_1_points > frame.player_2_points
              table.number_of_win_frames += 1
              table.number_of_win_small_points += frame.player_1_points
              table.number_of_lose_small_points += frame.player_2_points
            elsif frame.player_2_points > frame.player_1_points
              table.number_of_lose_frames += 1
              table.number_of_win_small_points += frame.player_1_points
              table.number_of_lose_small_points += frame.player_2_points
            end
          end
        end

        round.matches.where(player_2_id: player.id).each do |match|

          if match.player_1_frames < match.player_2_frames
            table.number_of_matches += 1
            table.number_of_wins += 1
            table.points += league.win_points
          elsif match.player_1_frames > match.player_2_frames
            table.number_of_matches += 1
            table.number_of_loss += 1
            table.points += league.loss_points
          end

          match.frames.each do |frame|
            if frame.player_1_points < frame.player_2_points
              table.number_of_win_frames += 1
              table.number_of_win_small_points += frame.player_2_points
              table.number_of_lose_small_points += frame.player_1_points
            elsif frame.player_1_points > frame.player_2_points
              table.number_of_lose_frames += 1
              table.number_of_win_small_points += frame.player_2_points
              table.number_of_lose_small_points += frame.player_1_points
            end
          end
        end
      end
      table.diff_small_points = table.number_of_win_small_points - table.number_of_lose_small_points
      table.save
    end

    def update_positions(league)

      league.tables.order(points: :desc, diff_small_points: :desc).each_with_index do |table, i|
        table.position = i + 1

        table.save
      end

    end
end
