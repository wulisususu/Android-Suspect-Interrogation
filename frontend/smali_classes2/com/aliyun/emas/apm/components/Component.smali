.class public final Lcom/aliyun/emas/apm/components/Component;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/components/Component$Builder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;"
    }
.end annotation


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:Ljava/util/Set;

.field public final c:Ljava/util/Set;

.field public final d:I

.field public final e:I

.field public final f:Lcom/aliyun/emas/apm/components/ComponentFactory;

.field public final g:Ljava/util/Set;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILcom/aliyun/emas/apm/components/ComponentFactory;Ljava/util/Set;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component;->a:Ljava/lang/String;

    .line 4
    invoke-static {p2}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component;->b:Ljava/util/Set;

    .line 5
    invoke-static {p3}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component;->c:Ljava/util/Set;

    iput p4, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    iput p5, p0, Lcom/aliyun/emas/apm/components/Component;->e:I

    iput-object p6, p0, Lcom/aliyun/emas/apm/components/Component;->f:Lcom/aliyun/emas/apm/components/ComponentFactory;

    .line 9
    invoke-static {p7}, Ljava/util/Collections;->unmodifiableSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component;->g:Ljava/util/Set;

    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILcom/aliyun/emas/apm/components/ComponentFactory;Ljava/util/Set;Lcom/aliyun/emas/apm/components/Component$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p7}, Lcom/aliyun/emas/apm/components/Component;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILcom/aliyun/emas/apm/components/ComponentFactory;Ljava/util/Set;)V

    return-void
.end method

.method public static synthetic a(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public static synthetic b(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public static builder(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/components/Component$Builder;

    const/4 v1, 0x0

    new-array v1, v1, [Lcom/aliyun/emas/apm/components/Qualified;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;Lcom/aliyun/emas/apm/components/Component$a;)V

    return-object v0
.end method

.method public static varargs builder(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;[",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "-TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 4
    new-instance v0, Lcom/aliyun/emas/apm/components/Component$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;Lcom/aliyun/emas/apm/components/Component$a;)V

    return-object v0
.end method

.method public static builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Component$Builder;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Ljava/lang/Class;[Ljava/lang/Class;Lcom/aliyun/emas/apm/components/Component$a;)V

    return-object v0
.end method

.method public static varargs builder(Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;[",
            "Ljava/lang/Class<",
            "-TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Component$Builder;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Ljava/lang/Class;[Ljava/lang/Class;Lcom/aliyun/emas/apm/components/Component$a;)V

    return-object v0
.end method

.method public static synthetic c(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public static synthetic d(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public static synthetic e(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    return-object p0
.end method

.method public static intoSet(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .line 2
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Component;->intoSetBuilder(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p1

    new-instance v0, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda4;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda4;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method

.method public static intoSet(Ljava/lang/Object;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Component;->intoSetBuilder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p1

    new-instance v0, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda3;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda3;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method

.method public static intoSetBuilder(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .line 2
    invoke-static {p0}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a(Lcom/aliyun/emas/apm/components/Component$Builder;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    return-object p0
.end method

.method public static intoSetBuilder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-static {p0}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-static {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a(Lcom/aliyun/emas/apm/components/Component$Builder;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    return-object p0
.end method

.method public static of(Ljava/lang/Class;Ljava/lang/Object;)Lcom/aliyun/emas/apm/components/Component;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;TT;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1
    invoke-static {p0}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    new-instance v0, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda0;

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda0;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method

.method public static varargs of(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;[",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "-TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 3
    invoke-static {p1, p2}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p1

    new-instance p2, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda1;

    invoke-direct {p2, p0}, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda1;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method

.method public static varargs of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;",
            "Ljava/lang/Class<",
            "TT;>;[",
            "Ljava/lang/Class<",
            "-TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .annotation runtime Ljava/lang/SafeVarargs;
    .end annotation

    .line 2
    invoke-static {p1, p2}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p1

    new-instance p2, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda2;

    invoke-direct {p2, p0}, Lcom/aliyun/emas/apm/components/Component$$ExternalSyntheticLambda2;-><init>(Ljava/lang/Object;)V

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public getDependencies()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/aliyun/emas/apm/components/Dependency;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component;->c:Ljava/util/Set;

    return-object v0
.end method

.method public getFactory()Lcom/aliyun/emas/apm/components/ComponentFactory;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/ComponentFactory<",
            "TT;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component;->f:Lcom/aliyun/emas/apm/components/ComponentFactory;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component;->a:Ljava/lang/String;

    return-object v0
.end method

.method public getProvidedInterfaces()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "-TT;>;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component;->b:Ljava/util/Set;

    return-object v0
.end method

.method public getPublishedEvents()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Ljava/lang/Class<",
            "*>;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component;->g:Ljava/util/Set;

    return-object v0
.end method

.method public isAlwaysEager()Z
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public isEagerInDefaultApp()Z
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isLazy()Z
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isValue()Z
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/components/Component;->e:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Component<"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Component;->b:Ljava/util/Set;

    .line 3
    invoke-interface {v1}, Ljava/util/Set;->toArray()[Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ">{"

    .line 4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    .line 5
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", type="

    .line 6
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/components/Component;->e:I

    .line 7
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", deps="

    .line 8
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Component;->c:Ljava/util/Set;

    .line 9
    invoke-interface {v1}, Ljava/util/Set;->toArray()[Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    .line 10
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 11
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public withFactory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/ComponentFactory<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    .line 1
    new-instance v8, Lcom/aliyun/emas/apm/components/Component;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Component;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/Component;->b:Ljava/util/Set;

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/Component;->c:Ljava/util/Set;

    iget v4, p0, Lcom/aliyun/emas/apm/components/Component;->d:I

    iget v5, p0, Lcom/aliyun/emas/apm/components/Component;->e:I

    iget-object v7, p0, Lcom/aliyun/emas/apm/components/Component;->g:Ljava/util/Set;

    move-object v0, v8

    move-object v6, p1

    invoke-direct/range {v0 .. v7}, Lcom/aliyun/emas/apm/components/Component;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILcom/aliyun/emas/apm/components/ComponentFactory;Ljava/util/Set;)V

    return-object v8
.end method
