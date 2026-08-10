.class public abstract Lcom/aliyun/emas/apm/components/a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/components/a$b;,
        Lcom/aliyun/emas/apm/components/a$c;
    }
.end annotation


# direct methods
.method public static a(Ljava/util/Set;)Ljava/util/Set;
    .locals 3

    .line 33
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 34
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/a$b;

    .line 35
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/a$b;->d()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 36
    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public static a(Ljava/util/List;)V
    .locals 7

    .line 1
    invoke-static {p0}, Lcom/aliyun/emas/apm/components/a;->b(Ljava/util/List;)Ljava/util/Set;

    move-result-object v0

    .line 2
    invoke-static {v0}, Lcom/aliyun/emas/apm/components/a;->a(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v1

    const/4 v2, 0x0

    .line 5
    :cond_0
    invoke-interface {v1}, Ljava/util/Set;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_2

    .line 6
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/components/a$b;

    .line 7
    invoke-interface {v1, v3}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    .line 10
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/a$b;->b()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_1
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/aliyun/emas/apm/components/a$b;

    .line 11
    invoke-virtual {v5, v3}, Lcom/aliyun/emas/apm/components/a$b;->c(Lcom/aliyun/emas/apm/components/a$b;)V

    .line 12
    invoke-virtual {v5}, Lcom/aliyun/emas/apm/components/a$b;->d()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 13
    invoke-interface {v1, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 20
    :cond_2
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result p0

    if-ne v2, p0, :cond_3

    return-void

    .line 25
    :cond_3
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 26
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_4
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/a$b;

    .line 27
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/a$b;->d()Z

    move-result v2

    if-nez v2, :cond_4

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/a$b;->c()Z

    move-result v2

    if-nez v2, :cond_4

    .line 28
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/a$b;->a()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    invoke-interface {p0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 32
    :cond_5
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyCycleException;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/components/DependencyCycleException;-><init>(Ljava/util/List;)V

    throw v0
.end method

.method public static b(Ljava/util/List;)Ljava/util/Set;
    .locals 9

    .line 1
    new-instance v0, Ljava/util/HashMap;

    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_4

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/Component;

    .line 3
    new-instance v3, Lcom/aliyun/emas/apm/components/a$b;

    invoke-direct {v3, v1}, Lcom/aliyun/emas/apm/components/a$b;-><init>(Lcom/aliyun/emas/apm/components/Component;)V

    .line 4
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->getProvidedInterfaces()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/aliyun/emas/apm/components/Qualified;

    .line 5
    new-instance v6, Lcom/aliyun/emas/apm/components/a$c;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->isValue()Z

    move-result v7

    xor-int/lit8 v7, v7, 0x1

    invoke-direct {v6, v5, v7, v2}, Lcom/aliyun/emas/apm/components/a$c;-><init>(Lcom/aliyun/emas/apm/components/Qualified;ZLcom/aliyun/emas/apm/components/a$a;)V

    .line 6
    invoke-interface {v0, v6}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 7
    new-instance v7, Ljava/util/HashSet;

    invoke-direct {v7}, Ljava/util/HashSet;-><init>()V

    invoke-interface {v0, v6, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 9
    :cond_1
    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/util/Set;

    .line 10
    invoke-interface {v7}, Ljava/util/Set;->isEmpty()Z

    move-result v8

    if-nez v8, :cond_3

    invoke-static {v6}, Lcom/aliyun/emas/apm/components/a$c;->a(Lcom/aliyun/emas/apm/components/a$c;)Z

    move-result v6

    if-eqz v6, :cond_2

    goto :goto_1

    .line 11
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "Multiple components provide %s."

    .line 12
    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 14
    :cond_3
    :goto_1
    invoke-interface {v7, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 18
    :cond_4
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :cond_5
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_a

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 19
    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_6
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/components/a$b;

    .line 20
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/a$b;->a()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v4

    invoke-virtual {v4}, Lcom/aliyun/emas/apm/components/Component;->getDependencies()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_7
    :goto_2
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/aliyun/emas/apm/components/Dependency;

    .line 21
    invoke-virtual {v5}, Lcom/aliyun/emas/apm/components/Dependency;->isDirectInjection()Z

    move-result v6

    if-nez v6, :cond_8

    goto :goto_2

    .line 25
    :cond_8
    new-instance v6, Lcom/aliyun/emas/apm/components/a$c;

    .line 26
    invoke-virtual {v5}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v7

    invoke-virtual {v5}, Lcom/aliyun/emas/apm/components/Dependency;->isSet()Z

    move-result v5

    invoke-direct {v6, v7, v5, v2}, Lcom/aliyun/emas/apm/components/a$c;-><init>(Lcom/aliyun/emas/apm/components/Qualified;ZLcom/aliyun/emas/apm/components/a$a;)V

    invoke-interface {v0, v6}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Set;

    if-nez v5, :cond_9

    goto :goto_2

    .line 30
    :cond_9
    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_7

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/aliyun/emas/apm/components/a$b;

    .line 31
    invoke-virtual {v3, v6}, Lcom/aliyun/emas/apm/components/a$b;->a(Lcom/aliyun/emas/apm/components/a$b;)V

    .line 32
    invoke-virtual {v6, v3}, Lcom/aliyun/emas/apm/components/a$b;->b(Lcom/aliyun/emas/apm/components/a$b;)V

    goto :goto_3

    .line 38
    :cond_a
    new-instance p0, Ljava/util/HashSet;

    invoke-direct {p0}, Ljava/util/HashSet;-><init>()V

    .line 39
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_4
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_b

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Set;

    .line 40
    invoke-virtual {p0, v1}, Ljava/util/AbstractCollection;->addAll(Ljava/util/Collection;)Z

    goto :goto_4

    :cond_b
    return-object p0
.end method
