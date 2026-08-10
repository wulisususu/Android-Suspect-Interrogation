.class public Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentRegistrar;


# direct methods
.method public static synthetic $r8$lambda$4x6pc9SF9KbbZ4DDySHBY89scRY(Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar;->a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;
    .locals 7

    .line 1
    const-class v0, Lcom/aliyun/emas/apm/ApmContext;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/ApmContext;

    .line 2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/ApmOptions;->getComponents()Ljava/util/List;

    move-result-object v1

    .line 4
    const-class v2, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLogComponent;

    invoke-interface {v1, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v2

    .line 5
    const-class v3, Lcom/aliyun/emas/apm/performance/ApmPerformanceComponent;

    invoke-interface {v1, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v2, :cond_1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return-object p1

    .line 7
    :cond_1
    :goto_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    .line 9
    const-class v5, Lcom/aliyun/emas/apm/events/Subscriber;

    invoke-interface {p1, v5}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/events/Subscriber;

    invoke-static {v0, v2, v1, p1}, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;->a(Lcom/aliyun/emas/apm/ApmContext;ZZLcom/aliyun/emas/apm/events/Subscriber;)Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;

    move-result-object p1

    .line 10
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sub-long/2addr v5, v3

    .line 11
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "Initializing"

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v3, ""

    if-eqz v1, :cond_2

    const-string v1, " Performance"

    goto :goto_1

    :cond_2
    move-object v1, v3

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    if-eqz v2, :cond_3

    const-string v3, " RemoteLog"

    :cond_3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " blocked main for "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Apm-RemoteLog"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-object p1
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;>;"
        }
    .end annotation

    const/4 v0, 0x2

    new-array v0, v0, [Lcom/aliyun/emas/apm/components/Component;

    .line 2
    const-class v1, Lcom/aliyun/emas/apm/remote/log/ApmRemoteLog;

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    const-string v2, "ApmRemoteLog"

    .line 3
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;->name(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 4
    const-class v3, Lcom/aliyun/emas/apm/ApmContext;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 5
    const-class v3, Lcom/aliyun/emas/apm/events/Subscriber;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0}, Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/remote/log/RemoteLogRegistrar;)V

    .line 6
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 7
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->eagerInDefaultApp()Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 8
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const-string v1, "2.0.0"

    .line 9
    invoke-static {v2, v1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;->create(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 10
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
