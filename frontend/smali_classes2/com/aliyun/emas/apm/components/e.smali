.class public final Lcom/aliyun/emas/apm/components/e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentContainer;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/components/e$a;
    }
.end annotation


# instance fields
.field public final a:Ljava/util/Set;

.field public final b:Ljava/util/Set;

.field public final c:Ljava/util/Set;

.field public final d:Ljava/util/Set;

.field public final e:Ljava/util/Set;

.field public final f:Ljava/util/Set;

.field public final g:Lcom/aliyun/emas/apm/components/ComponentContainer;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/components/Component;Lcom/aliyun/emas/apm/components/ComponentContainer;)V
    .locals 8

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    .line 3
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    .line 4
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    .line 5
    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .line 6
    new-instance v4, Ljava/util/HashSet;

    invoke-direct {v4}, Ljava/util/HashSet;-><init>()V

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Component;->getDependencies()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/aliyun/emas/apm/components/Dependency;

    .line 8
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->isDirectInjection()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 9
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->isSet()Z

    move-result v7

    if-eqz v7, :cond_0

    .line 10
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v6

    invoke-interface {v3, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 12
    :cond_0
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v6

    invoke-interface {v0, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 14
    :cond_1
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->isDeferred()Z

    move-result v7

    if-eqz v7, :cond_2

    .line 15
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v6

    invoke-interface {v2, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 17
    :cond_2
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->isSet()Z

    move-result v7

    if-eqz v7, :cond_3

    .line 18
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v6

    invoke-interface {v4, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 20
    :cond_3
    invoke-virtual {v6}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v6

    invoke-interface {v1, v6}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 24
    :cond_4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Component;->getPublishedEvents()Ljava/util/Set;

    move-result-object v5

    invoke-interface {v5}, Ljava/util/Set;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_5

    .line 25
    const-class v5, Lcom/aliyun/emas/apm/events/Publisher;

    invoke-static {v5}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v5

    invoke-interface {v0, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 27
    :cond_5
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/e;->a:Ljava/util/Set;

    .line 28
    invoke-static {v1}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/e;->b:Ljava/util/Set;

    .line 29
    invoke-static {v2}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/e;->c:Ljava/util/Set;

    .line 30
    invoke-static {v3}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/e;->d:Ljava/util/Set;

    .line 31
    invoke-static {v4}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/e;->e:Ljava/util/Set;

    .line 32
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Component;->getPublishedEvents()Ljava/util/Set;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/e;->f:Ljava/util/Set;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    return-void
.end method


# virtual methods
.method public get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->a:Ljava/util/Set;

    .line 19
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 23
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    .line 24
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency %s."

    .line 25
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public get(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->a:Ljava/util/Set;

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 10
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    .line 11
    const-class v1, Lcom/aliyun/emas/apm/events/Publisher;

    invoke-virtual {p1, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    return-object v0

    .line 16
    :cond_0
    new-instance p1, Lcom/aliyun/emas/apm/components/e$a;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/e;->f:Ljava/util/Set;

    check-cast v0, Lcom/aliyun/emas/apm/events/Publisher;

    invoke-direct {p1, v1, v0}, Lcom/aliyun/emas/apm/components/e$a;-><init>(Ljava/util/Set;Lcom/aliyun/emas/apm/events/Publisher;)V

    return-object p1

    .line 17
    :cond_1
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency %s."

    .line 18
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->c:Ljava/util/Set;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 7
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;

    move-result-object p1

    return-object p1

    .line 8
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency Deferred<%s>."

    .line 9
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getDeferred(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Deferred;
    .locals 0

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/e;->getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;

    move-result-object p1

    return-object p1
.end method

.method public getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->b:Ljava/util/Set;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 7
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1

    .line 8
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency Provider<%s>."

    .line 9
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 0

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/e;->getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1
.end method

.method public setOf(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/util/Set;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->d:Ljava/util/Set;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 5
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOf(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/util/Set;

    move-result-object p1

    return-object p1

    .line 6
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency Set<%s>."

    .line 7
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->e:Ljava/util/Set;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/e;->g:Lcom/aliyun/emas/apm/components/ComponentContainer;

    .line 7
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1

    .line 8
    :cond_0
    new-instance v0, Lcom/aliyun/emas/apm/components/DependencyException;

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "Attempting to request an undeclared dependency Provider<Set<%s>>."

    .line 9
    invoke-static {v1, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/DependencyException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setOfProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 0

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/e;->setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1
.end method
