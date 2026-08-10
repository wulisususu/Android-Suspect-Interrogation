.class public Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentRegistrar;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/components/Qualified;

.field private final b:Lcom/aliyun/emas/apm/components/Qualified;


# direct methods
.method public static synthetic $r8$lambda$SmRHknomcopF7gm6zIH8fBCgVXE(Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>()V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 4
    const-class v0, Lcom/aliyun/emas/apm/annotations/concurrent/Background;

    const-class v1, Ljava/util/concurrent/ExecutorService;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 6
    const-class v0, Lcom/aliyun/emas/apm/annotations/concurrent/Blocking;

    const-class v1, Ljava/util/concurrent/ExecutorService;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->b:Lcom/aliyun/emas/apm/components/Qualified;

    return-void
.end method

.method private a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;
    .locals 10

    .line 1
    const-class v0, Lcom/aliyun/emas/apm/ApmContext;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Lcom/aliyun/emas/apm/ApmContext;

    .line 2
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/ApmContext;->getOptions()Lcom/aliyun/emas/apm/ApmOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/ApmOptions;->getComponents()Ljava/util/List;

    move-result-object v0

    .line 3
    const-class v2, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysisComponent;

    invoke-interface {v0, v2}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 7
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    .line 12
    const-class v0, Lcom/aliyun/emas/apm/ApmSession;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    move-object v2, v0

    check-cast v2, Lcom/aliyun/emas/apm/ApmSession;

    .line 13
    const-class v0, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->getDeferred(Ljava/lang/Class;)Lcom/aliyun/emas/apm/inject/Deferred;

    move-result-object v3

    .line 14
    const-class v0, Lcom/aliyun/emas/apm/events/Subscriber;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    move-object v4, v0

    check-cast v4, Lcom/aliyun/emas/apm/events/Subscriber;

    .line 15
    const-class v0, Lcom/aliyun/emas/apm/settings/SettingProvider;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    move-object v5, v0

    check-cast v5, Lcom/aliyun/emas/apm/settings/SettingProvider;

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 16
    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;

    move-result-object v0

    move-object v6, v0

    check-cast v6, Ljava/util/concurrent/ExecutorService;

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->b:Lcom/aliyun/emas/apm/components/Qualified;

    .line 17
    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Lcom/aliyun/emas/apm/components/Qualified;)Ljava/lang/Object;

    move-result-object p1

    move-object v7, p1

    check-cast v7, Ljava/util/concurrent/ExecutorService;

    .line 18
    invoke-static/range {v1 .. v7}, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;->a(Lcom/aliyun/emas/apm/ApmContext;Lcom/aliyun/emas/apm/ApmSession;Lcom/aliyun/emas/apm/inject/Deferred;Lcom/aliyun/emas/apm/events/Subscriber;Lcom/aliyun/emas/apm/settings/SettingProvider;Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ExecutorService;)Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    move-result-object p1

    .line 27
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sub-long/2addr v0, v8

    .line 28
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v2

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Initializing CrashAnalysis blocked main for "

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->i(Ljava/lang/String;)V

    return-object p1

    :cond_0
    const/4 p1, 0x0

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
    const-class v1, Lcom/aliyun/emas/apm/crash/ApmCrashAnalysis;

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    const-string v2, "ApmCrashAnalysis"

    .line 3
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;->name(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 4
    const-class v3, Lcom/aliyun/emas/apm/ApmContext;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 5
    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;->b:Lcom/aliyun/emas/apm/components/Qualified;

    .line 6
    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 7
    const-class v3, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->deferred(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 8
    const-class v3, Lcom/aliyun/emas/apm/events/Subscriber;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 9
    const-class v3, Lcom/aliyun/emas/apm/ApmSession;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 10
    const-class v3, Lcom/aliyun/emas/apm/settings/SettingProvider;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0}, Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/CrashAnalysisRegistrar;)V

    .line 11
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 12
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->eagerInDefaultApp()Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 13
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const-string v1, "3.2.0"

    .line 14
    invoke-static {v2, v1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;->create(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 15
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
