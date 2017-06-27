module MyMatching
function my_deferred_acceptance(prop_prefs::Vector{Vector{Int}},
                                 resp_prefs::Vector{Vector{Int}},
                                 caps::Vector{Int})

    m = length(prop_prefs)
    n = length(resp_prefs)
    L = sum(caps)
    prop_matched = Vector{Int}(m)
    resp_matched = Vector{Int}(L)
    prop_matched[1:end] = 0 
    resp_matched[1:end] = 0
    indptr = Array{Int}(n+1)
    indptr[1] = 1
        for i in 1:n
            indptr[i+1] = indptr[i] + caps[i]
        end
    
    count = 1
    while count <= n
        s = 1
        while s <= m
            p = 1
            while p <= length(prop_prefs[s])
                if prop_matched[s] == 0
                    s_pref = prop_prefs[s] #生徒の選好
                    o = s_pref[p]
                    o_pref = resp_prefs[o] #生徒が希望する進学先の選好
                    o_matched = resp_matched[indptr[o]:indptr[o+1]-1]
                    if s in resp_prefs[o]
                        if 0 in o_matched 
                            j = 1
                            while j <= caps[o]
                                if !(o_matched[j] == 0)
                                    j += 1
                                end
                                break
                            end
                            prop_matched[s] = o
                            resp_matched[indptr[o]+j-1] = s
                        else
                            a = 1
                            while !(s == o_pref[a])
                                a +=1
                            end
                            b = copy(a)
                            while b < length(o_pref) #sよりoの選好が低い生徒を探す
                                b += 1
                                if o_pref[b] == 0
                                    break
                                end
                                if prop_matched[o_pref[b]] == o #o_pref[b]はsのライバル
                                    prop_matched[o_pref[b]] = 0
                                    prop_matched[s] = o
                                    c = 1
                                    while !(resp_matched[indptr[o]+c-1] == o_pref[b]) 
                                        c += 1
                                    end
                                    resp_matched[indptr[o]+c-1] = s
                                    break
                                end
                            end
                        end
                    end
                end
                p += 1
            end
            s += 1
        end
        count += 1
    end
    return prop_matched, resp_matched, indptr
end

# 一対一のケース：capsが指定されなかった場合
function my_deferred_acceptance(prop_prefs::Vector{Vector{Int}},
                                 resp_prefs::Vector{Vector{Int}})
    caps = ones(Int, length(resp_prefs))
    prop_matched, resp_matched, indptr =
        my_deferred_acceptance(prop_prefs, resp_prefs, caps)
    return prop_matched, resp_matched
end
export my_deferred_acceptance
end
