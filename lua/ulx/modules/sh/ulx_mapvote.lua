function ulx.mapvote(calling_ply, time, opposite)
    if opposite then
        lps.mapvote:Cancel()
        ulx.fancyLogAdmin(calling_ply, "#A stopped the mapvote!")
    else
        lps.mapvote:Start(voteTime)
        ulx.fancyLogAdmin(calling_ply, "#A started a mapvote!")
    end
end

function ulx.rtvreset(calling_ply)
    lps.mapvote:ResetRTV()
    ulx.fancyLogAdmin(calling_ply, "#A reset the RTV.")
end