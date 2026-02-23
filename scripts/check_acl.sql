SELECT a.name,
       m.model,
    COALESCE(g.name->>'en_US', '(sin grupo)') AS grupo,
       a.perm_read,
       a.perm_write,
       a.perm_create,
       a.perm_unlink,
       a.active
FROM ir_model_access a
JOIN ir_model m ON a.model_id = m.id
LEFT JOIN res_groups g ON a.group_id = g.id
WHERE m.model LIKE 'dronify.%'
ORDER BY m.model, a.name;
