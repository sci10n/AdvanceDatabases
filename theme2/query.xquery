declare function local:recommends($exp as xs:string, $topic as xs:string) 
as xs:string*
{
(: return expert if it is not recommending any experts :)
if (empty(doc('data.xml')/database/recomendations/recomendation[from=$exp])) then (
    if (local:expertOf($exp, $topic)) then (
        $exp
    ) else ()
)
else
    for $x in doc('data.xml')/database/recomendations/recomendation
    where $x/from=$exp
    return local:recommends($x/to, $topic) 
};


declare function local:expertOf($expert as xs:string, $topic as xs:string)
as xs:boolean
{
    not(empty(doc('data.xml')/database/experts/expert[name=$expert][expertof=$topic]))
};

<res>
{doc('data.xml')/database/recomendations/recomendation[from="Maxwell"]}
{empty(doc('data.xml')/database/recomendations/recomendation[from="Mr. Smith"])}


Experts of Geology
{doc('data.xml')/database/experts/expert[expertof="Geology"]}
Subtopics of Geology
{doc('data.xml')/database/topics/topic[subtopicof="Geology"]}
Experts of Geology recomended by maxwell
{for $x in doc('data.xml')/database/recomendations/recomendation[from="Maxwell"],
    $e in doc('data.xml')/database/experts/expert
where $x/to = $e/name and $e/expertof = "Geology"
return $e/name}

Expert of Geology that are recomended by experts that are recomended by experts
{for $x in doc('data.xml')/database/recomendations/recomendation[from="Maxwell"],
     $y in doc('data.xml')/database/recomendations/recomendation,
     $e in doc('data.xml')/database/experts/expert
where $x/to = $y/from and $y/to = $e/name and $e/expertof = "Geology"
return $e}


Expert of Geology that are recommended by experts that are recommended by experts ...
{for $x in distinct-values(local:recommends("Maxwell", "Geology")),
     $y in doc('data.xml')/database/experts/expert
where $y/name = $x
return $y}

Experts:
{doc('data.xml')/database/experts/expert}

{doc('data.xml')/database/topics/topic[originator='Maxwell']}

{doc('data.xml')/database/recomendations/recomendation[from='Maxwell']}
</res>

