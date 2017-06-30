
using MyMatching

Pkg.test("MyMatching")

using ShingakuMatching

departments = get_departments()

num_students = 300 #number of students
students = get_students(num_students)

prop_prefs, resp_prefs, caps = get_random_prefs(students, departments)

prop_matched, resp_matched, indptr = my_deferred_acceptance(prop_prefs, resp_prefs, caps)

r = 1
while r <= length(resp_prefs)
    if (resp_matched[indptr[r]:indptr[r+1]-1] == [0])
        println("resp $r ""got no student.")
    end
    r += 1
end

j = 4
resp_matched[indptr[j]:indptr[j+1]-1]

j = 5
resp_matched[indptr[j]:indptr[j+1]-1]

j = 22
resp_matched[indptr[j]:indptr[j+1]-1]

j = 32
resp_matched[indptr[j]:indptr[j+1]-1]

resp_num = Vector{Int}(length(resp_prefs))
for u in 1:length(resp_prefs)
    u_matched = resp_matched[indptr[u]:indptr[u+1]-1]
    stu_num = 1
    while !(u_matched[stu_num] == 0)
        stu_num += 1
        if stu_num > length(u_matched)
            break
        end
    end
    resp_num[u] = stu_num -1
end

resp_num

maximum(resp_num)

for max_resp in 1:length(resp_prefs)
    if !(resp_num[max_resp] == maximum(resp_num))
        max_resp += 1
    else
        print(max_resp)
        break
    end
end  

function student_pref_rank(resp_number)
    x = 1
    while x <= num_students
        if x in resp_matched[indptr[resp_number]:indptr[resp_number+1]-1]
            pref_rank = 1
            x_pref = prop_prefs[x]
            while !(x_pref[pref_rank] == resp_number)
                pref_rank += 1
            end
            println("student $x; ""pref_rank = $pref_rank")
        end
        x += 1
    end
end

student_pref_rank(122)

function student_resp_rank(resp_number)
    w = resp_matched[indptr[resp_number]:indptr[resp_number+1]-1]
    for y in 1: caps[resp_number]
        if !(w[y] == 0) 
            resp_rank = 1
            pref = resp_prefs[resp_number]
            while !(pref[resp_rank] == w[y])
                resp_rank += 1
            end
            stu = w[y]
            println("student $stu; ""resp_rank = $resp_rank")
        else
            break
        end
    end
end

student_resp_rank(122)


