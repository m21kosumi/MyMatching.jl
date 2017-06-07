module MyMatching
function my_deferred_acceptance(m_prefs::Vector{Vector{Int}},f_prefs::Vector{Vector{Int}})
    #初期設定
    m = length(m_prefs)
    n = length(f_prefs)
    m_matched = Vector{Int}(m)
    f_matched = Vector{Int}(n)
    m_matched[1:end] = 0 
    f_matched[1:end] = 0

    count = 0 #既婚または選好をすべて実施した男性の数
    while (count <= m)
        for h in 1:m
            if (m_matched[h] == 0) && !(m_prefs[h] == [0]) #hが未婚かつhが未実行の選好を持つ
                h_pref = m_prefs[h] #hの選好
                d = h_pref[1] #hのプロポーズ相手d
                d_pref = f_prefs[d] #dの選好
                if (f_matched[d] == 0) && (h in d_pref)#dが未婚かつdの選好にhが含まれる
                    f_matched[d] = h
                    m_matched[h] = d
                    if length(m_prefs[h]) == 1
                        m_prefs[h] = [0]
                    else
                        shift!(m_prefs[h])
                    end
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
                        if length(m_prefs[h]) == 1
                            m_prefs[h] = [0]
                        else
                            shift!(m_prefs[h])
                        end
                    else
                        if length(m_prefs[h]) == 1
                        m_prefs[h] = [0]
                        else
                        shift!(m_prefs[h])
                        end
                    end
                end
            else
                count +=1
            end
        end      
    end
    return m_matched,f_matched 
end
export my_deferred_acceptance
end
