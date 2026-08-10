.class public final Lcom/aliyun/emas/apm/components/ComponentDiscovery;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/components/ComponentDiscovery$b;,
        Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;
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
.field public final a:Ljava/lang/Object;

.field public final b:Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;


# direct methods
.method public constructor <init>(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->a:Ljava/lang/Object;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->b:Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;

    return-void
.end method

.method public static a(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;
    .locals 7

    const-string v0, "Could not instantiate %s"

    const-string v1, "Could not instantiate %s."

    .line 1
    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v2

    .line 2
    const-class v3, Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    invoke-virtual {v3, v2}, Ljava/lang/Class;->isAssignableFrom(Ljava/lang/Class;)Z

    move-result v3

    const/4 v4, 0x0

    if-eqz v3, :cond_0

    new-array v3, v4, [Ljava/lang/Class;

    .line 7
    invoke-virtual {v2, v3}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v2

    new-array v3, v4, [Ljava/lang/Object;

    invoke-virtual {v2, v3}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    return-object v2

    .line 8
    :cond_0
    new-instance v2, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;

    const-string v3, "Class %s is not an instance of %s"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    aput-object p0, v5, v4

    const-string v4, "com.aliyun.emas.apm.components.ComponentRegistrar"

    const/4 v6, 0x1

    aput-object v4, v5, v6

    .line 9
    invoke-static {v3, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception v1

    .line 27
    new-instance v2, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    .line 28
    invoke-static {v0, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0, v1}, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    :catch_1
    move-exception v1

    .line 29
    new-instance v2, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    .line 30
    invoke-static {v0, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0, v1}, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    :catch_2
    move-exception v0

    .line 31
    new-instance v2, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    .line 32
    invoke-static {v1, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0, v0}, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    :catch_3
    move-exception v0

    .line 33
    new-instance v2, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;

    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    .line 34
    invoke-static {v1, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v2, p0, v0}, Lcom/aliyun/emas/apm/components/InvalidRegistrarException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 35
    :catch_4
    filled-new-array {p0}, [Ljava/lang/Object;

    move-result-object p0

    const-string v0, "Class %s is not an found."

    invoke-static {v0, p0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "ComponentDiscovery"

    invoke-static {v0, p0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 p0, 0x0

    return-object p0
.end method

.method public static synthetic b(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;
    .locals 0

    .line 1
    invoke-static {p0}, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->a(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    move-result-object p0

    return-object p0
.end method

.method public static forContext(Landroid/content/Context;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/ComponentDiscovery;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/lang/Class<",
            "+",
            "Landroid/app/Service;",
            ">;)",
            "Lcom/aliyun/emas/apm/components/ComponentDiscovery<",
            "Landroid/content/Context;",
            ">;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;

    new-instance v1, Lcom/aliyun/emas/apm/components/ComponentDiscovery$b;

    const/4 v2, 0x0

    invoke-direct {v1, p1, v2}, Lcom/aliyun/emas/apm/components/ComponentDiscovery$b;-><init>(Ljava/lang/Class;Lcom/aliyun/emas/apm/components/ComponentDiscovery$a;)V

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/components/ComponentDiscovery;-><init>(Ljava/lang/Object;Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;)V

    return-object v0
.end method


# virtual methods
.method public discover()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/components/ComponentRegistrar;",
            ">;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->b:Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->a:Ljava/lang/Object;

    .line 2
    invoke-interface {v1, v2}, Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;->a(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 4
    :try_start_0
    invoke-static {v2}, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->a(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 6
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lcom/aliyun/emas/apm/components/InvalidRegistrarException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    const-string v3, "ComponentDiscovery"

    const-string v4, "Invalid component registrar."

    .line 9
    invoke-static {v3, v4, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method public discoverLazy()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "Lcom/aliyun/emas/apm/components/ComponentRegistrar;",
            ">;>;"
        }
    .end annotation

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->b:Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->a:Ljava/lang/Object;

    .line 2
    invoke-interface {v1, v2}, Lcom/aliyun/emas/apm/components/ComponentDiscovery$c;->a(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 3
    new-instance v3, Lcom/aliyun/emas/apm/components/ComponentDiscovery$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2}, Lcom/aliyun/emas/apm/components/ComponentDiscovery$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-object v0
.end method
