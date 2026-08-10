.class public Lcom/aliyun/emas/apm/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;


# direct methods
.method public static synthetic $r8$lambda$9voKMbb1YPYT_9zQOctqV5OrxbM(Ljava/lang/String;Lcom/aliyun/emas/apm/components/Component;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/aliyun/emas/apm/d;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/components/Component;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static synthetic a(Ljava/lang/String;Lcom/aliyun/emas/apm/components/Component;Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;
    .locals 0

    .line 1
    :try_start_0
    invoke-static {p0}, Lcom/aliyun/emas/apm/a;->a(Ljava/lang/String;)V

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Component;->getFactory()Lcom/aliyun/emas/apm/components/ComponentFactory;

    move-result-object p0

    invoke-interface {p0, p2}, Lcom/aliyun/emas/apm/components/ComponentFactory;->create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 4
    invoke-static {}, Lcom/aliyun/emas/apm/a;->a()V

    return-object p0

    :catchall_0
    move-exception p0

    .line 5
    invoke-static {}, Lcom/aliyun/emas/apm/a;->a()V

    .line 6
    throw p0
.end method


# virtual methods
.method public processRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Ljava/util/List;
    .locals 4

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 2
    invoke-interface {p1}, Lcom/aliyun/emas/apm/components/ComponentRegistrar;->getComponents()Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/Component;

    .line 3
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->getName()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 7
    new-instance v3, Lcom/aliyun/emas/apm/d$$ExternalSyntheticLambda0;

    invoke-direct {v3, v2, v1}, Lcom/aliyun/emas/apm/d$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/components/Component;)V

    .line 8
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component;->withFactory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    .line 18
    :cond_0
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    return-object v0
.end method
