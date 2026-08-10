.class public Lcom/aliyun/emas/apm/components/Component$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/components/Component;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
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
.field public a:Ljava/lang/String;

.field public final b:Ljava/util/Set;

.field public final c:Ljava/util/Set;

.field public d:I

.field public e:I

.field public f:Lcom/aliyun/emas/apm/components/ComponentFactory;

.field public final g:Ljava/util/Set;


# direct methods
.method public varargs constructor <init>(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)V
    .locals 3

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->a:Ljava/lang/String;

    .line 21
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    .line 22
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iput-object v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->c:Ljava/util/Set;

    const/4 v1, 0x0

    iput v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->d:I

    iput v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->e:I

    .line 26
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->g:Ljava/util/Set;

    const-string v2, "Null interface"

    .line 40
    invoke-static {p1, v2}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 41
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 42
    array-length p1, p2

    :goto_0
    if-ge v1, p1, :cond_0

    aget-object v0, p2, v1

    .line 43
    invoke-static {v0, v2}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    .line 45
    invoke-static {p1, p2}, Ljava/util/Collections;->addAll(Ljava/util/Collection;[Ljava/lang/Object;)Z

    return-void
.end method

.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;Lcom/aliyun/emas/apm/components/Component$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)V

    return-void
.end method

.method public varargs constructor <init>(Ljava/lang/Class;[Ljava/lang/Class;)V
    .locals 4

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->a:Ljava/lang/String;

    .line 5
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    .line 6
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    iput-object v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->c:Ljava/util/Set;

    const/4 v1, 0x0

    iput v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->d:I

    iput v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->e:I

    .line 10
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    iput-object v2, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->g:Ljava/util/Set;

    const-string v2, "Null interface"

    .line 14
    invoke-static {p1, v2}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 15
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 16
    array-length p1, p2

    :goto_0
    if-ge v1, p1, :cond_0

    aget-object v0, p2, v1

    .line 17
    invoke-static {v0, v2}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    .line 18
    invoke-static {v0}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v0

    invoke-interface {v3, v0}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/Class;[Ljava/lang/Class;Lcom/aliyun/emas/apm/components/Component$a;)V
    .locals 0

    .line 2
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/components/Component$Builder;-><init>(Ljava/lang/Class;[Ljava/lang/Class;)V

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/Component$Builder;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 0

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a()Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final a()Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1

    const/4 v0, 0x1

    iput v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->e:I

    return-object p0
.end method

.method public final a(I)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->d:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v1, "Instantiation type has already been set."

    .line 2
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/Preconditions;->checkState(ZLjava/lang/String;)V

    iput p1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->d:I

    return-object p0
.end method

.method public final a(Lcom/aliyun/emas/apm/components/Qualified;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    .line 6
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    xor-int/lit8 p1, p1, 0x1

    const-string v0, "Components are not allowed to depend on interfaces they themselves provide."

    .line 7
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/components/Preconditions;->checkArgument(ZLjava/lang/String;)V

    return-void
.end method

.method public add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Dependency;",
            ")",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    const-string v0, "Null dependency"

    .line 1
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a(Lcom/aliyun/emas/apm/components/Qualified;)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->c:Ljava/util/Set;

    .line 3
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public alwaysEager()Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    const/4 v0, 0x1

    .line 1
    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a(I)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    return-object v0
.end method

.method public build()Lcom/aliyun/emas/apm/components/Component;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/Component<",
            "TT;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->f:Lcom/aliyun/emas/apm/components/ComponentFactory;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string v1, "Missing required property: factory."

    .line 1
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/Preconditions;->checkState(ZLjava/lang/String;)V

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Component;

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->a:Ljava/lang/String;

    new-instance v4, Ljava/util/HashSet;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->b:Ljava/util/Set;

    invoke-direct {v4, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    new-instance v5, Ljava/util/HashSet;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->c:Ljava/util/Set;

    invoke-direct {v5, v1}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    iget v6, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->d:I

    iget v7, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->e:I

    iget-object v8, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->f:Lcom/aliyun/emas/apm/components/ComponentFactory;

    iget-object v9, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->g:Ljava/util/Set;

    const/4 v10, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v10}, Lcom/aliyun/emas/apm/components/Component;-><init>(Ljava/lang/String;Ljava/util/Set;Ljava/util/Set;IILcom/aliyun/emas/apm/components/ComponentFactory;Ljava/util/Set;Lcom/aliyun/emas/apm/components/Component$a;)V

    return-object v0
.end method

.method public eagerInDefaultApp()Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    const/4 v0, 0x2

    .line 1
    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->a(I)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    return-object v0
.end method

.method public factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/ComponentFactory<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    const-string v0, "Null factory"

    .line 1
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/components/ComponentFactory;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->f:Lcom/aliyun/emas/apm/components/ComponentFactory;

    return-object p0
.end method

.method public name(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->a:Ljava/lang/String;

    return-object p0
.end method

.method public publishes(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Component$Builder<",
            "TT;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Component$Builder;->g:Ljava/util/Set;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-object p0
.end method
