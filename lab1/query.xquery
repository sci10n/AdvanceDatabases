declare function local:recomends($exp as xs:string, $recomendations as element(recomendations))
{  
     let $rec := $recomendations/recomendation[from = $exp]
     if (!empty($rec)) then(
        for $x in $rec/to
        return local:recomends( $x, $recomendations)
        
        )
     
};


<res>
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
return $e/name}

Expert of Geology that are recomended by experts that are recomended by experts ...
{local:recomends("Maxwell", doc('data.xml')/database/recomendations)}

Experts:
{doc('data.xml')/database/experts/expert}

{doc('data.xml')/database/topics/topic[originator='Maxwell']}

{doc('data.xml')/database/recomendations/recomendation[from='Maxwell']}
</res>

