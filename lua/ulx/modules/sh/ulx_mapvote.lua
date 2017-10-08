function ulx.mapvote(calling_ply, time, opposite)
    if opposite then
        MapVote:Stop()
        ulx.fancyLogAdmin(calling_ply, "#A stopped the mapvote!")
    else
        MapVote:Start(time)
        ulx.fancyLogAdmin(calling_ply, "#A started a mapvote!")
    end
end

function ulx.rtvreset(calling_ply)
    RTV:Reset()
    ulx.fancyLogAdmin(calling_ply, "#A reset the RTV.")
end