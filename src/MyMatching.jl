module MyMatching
function my_deferred_acceptance2(m_prefs,f_prefs)
    #初期設定
    m = length(m_prefs)
    n = length(f_prefs)
    m_matched = Vector{Int}(m)
    f_matched = Vector{Int}(n)
    m_matched[1:end] = 0 
    f_matched[1:end] = 0

    count = 1
    while count <= n
        h = 1
        while h <= m
            l = 1
            while l <= length(m_prefs[h])
                if m_matched[h] == 0
                    h_pref = m_prefs[h] #hの選好
                    d = h_pref[l] #hのプロポーズ相手d
                    d_pref = f_prefs[d] #dの選好
                    if (f_matched[d] == 0) && (h in d_pref)#dが未婚かつdの選好にhが含まれる
                        f_matched[d] = h
                        m_matched[h] = d
                    end
                    if !(f_matched[d] == 0) && (h in d_pref)
                        p = f_matched[d] #dの結婚相手p
                        i = 1
                        j = 1
                        while !(d_pref[i] == p)
                            i += 1
                        end
                        while !(d_pref[j] == h)
                            j += 1
                        end
                        if i > j
                            m_matched[h] = d
                            f_matched[d] = h
                            m_matched[p] = 0
                        end
                    end
                end
                l += 1
            end
            h +=1
        end  
        count +=1
    end
    return m_matched,f_matched
end
export my_deferred_acceptance
end
