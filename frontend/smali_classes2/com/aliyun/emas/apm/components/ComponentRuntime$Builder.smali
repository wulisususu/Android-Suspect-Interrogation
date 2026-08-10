.class public final Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/components/ComponentRuntime;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field public final a:Ljava/util/concurrent/Executor;

.field public final b:Ljava/util/List;

.field public final c:Ljava/util/List;

.field public d:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;


# direct methods
.method public constructor <init>(Ljava/util/concurrent/Executor;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->b:Ljava/util/List;

    .line 3
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->c:Ljava/util/List;

    .line 4
    sget-object v0, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;->NOOP:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->d:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->a:Ljava/util/concurrent/Executor;

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;
    .locals 0

    return-object p0
.end method


# virtual methods
.method public addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->c:Ljava/util/List;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public addComponentRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->b:Ljava/util/List;

    .line 1
    new-instance v1, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-object p0
.end method

.method public addLazyComponentRegistrars(Ljava/util/Collection;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "Lcom/aliyun/emas/apm/components/ComponentRegistrar;",
            ">;>;)",
            "Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->b:Ljava/util/List;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    return-object p0
.end method

.method public build()Lcom/aliyun/emas/apm/components/ComponentRuntime;
    .locals 7

    .line 1
    new-instance v6, Lcom/aliyun/emas/apm/components/ComponentRuntime;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->a:Ljava/util/concurrent/Executor;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->b:Ljava/util/List;

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->c:Ljava/util/List;

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->d:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    const/4 v5, 0x0

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/components/ComponentRuntime;-><init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;Ljava/util/Collection;Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;Lcom/aliyun/emas/apm/components/ComponentRuntime$a;)V

    return-object v6
.end method

.method public setProcessor(Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->d:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    return-object p0
.end method
