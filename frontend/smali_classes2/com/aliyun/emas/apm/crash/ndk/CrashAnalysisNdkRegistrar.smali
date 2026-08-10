.class public Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentRegistrar;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;
    .locals 1

    .line 1
    const-class v0, Landroid/content/Context;

    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/content/Context;

    const/4 v0, 0x1

    .line 2
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/ndk/a;->a(Landroid/content/Context;Z)Lcom/aliyun/emas/apm/crash/ndk/a;

    move-result-object p1

    return-object p1
.end method

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
    const-class v1, Lcom/aliyun/emas/apm/crash/internal/CrashAnalysisNativeComponent;

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    const-string v2, "ApmCrashAnalysisNdk"

    .line 3
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;->name(Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 4
    const-class v3, Landroid/content/Context;

    invoke-static {v3}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar$$ExternalSyntheticLambda0;

    invoke-direct {v3, p0}, Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/ndk/CrashAnalysisNdkRegistrar;)V

    .line 5
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 6
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->eagerInDefaultApp()Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 7
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v3, 0x0

    aput-object v1, v0, v3

    const-string v1, "1.1.0"

    .line 8
    invoke-static {v2, v1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;->create(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v2, 0x1

    aput-object v1, v0, v2

    .line 9
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
