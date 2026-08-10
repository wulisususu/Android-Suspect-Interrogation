.class public interface abstract Lcom/aliyun/emas/apm/components/ComponentContainer;
.super Ljava/lang/Object;
.source "SourceFile"


# virtual methods
.method public get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)TT;"
        }
    .end annotation

    .line 2
    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 6
    :cond_0
    invoke-interface {p1}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public get(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public abstract getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Deferred<",
            "TT;>;"
        }
    .end annotation
.end method

.method public getDeferred(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Deferred;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Deferred<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;

    move-result-object p1

    return-object p1
.end method

.method public abstract getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "TT;>;"
        }
    .end annotation
.end method

.method public getProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1
.end method

.method public setOf(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/util/Set;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Ljava/util/Set<",
            "TT;>;"
        }
    .end annotation

    .line 2
    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    invoke-interface {p1}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/Set;

    return-object p1
.end method

.method public setOf(Ljava/lang/Class;)Ljava/util/Set;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Ljava/util/Set<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOf(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/util/Set;

    move-result-object p1

    return-object p1
.end method

.method public abstract setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "Ljava/util/Set<",
            "TT;>;>;"
        }
    .end annotation
.end method

.method public setOfProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "Ljava/util/Set<",
            "TT;>;>;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    return-object p1
.end method
