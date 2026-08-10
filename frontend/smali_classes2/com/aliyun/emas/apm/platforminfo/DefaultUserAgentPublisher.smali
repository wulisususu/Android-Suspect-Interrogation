.class public Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;


# instance fields
.field private final a:Ljava/lang/String;

.field private final b:Lcom/aliyun/emas/apm/platforminfo/b;


# direct methods
.method public static synthetic $r8$lambda$wMEEXXHwAi_Tj8AjlOkU2X8ihbs(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;

    move-result-object p0

    return-object p0
.end method

.method constructor <init>(Ljava/util/Set;Lcom/aliyun/emas/apm/platforminfo/b;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    invoke-static {p1}, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a(Ljava/util/Set;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    return-void
.end method

.method private static synthetic a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;
    .locals 2

    .line 11
    new-instance v0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;

    .line 12
    const-class v1, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    invoke-interface {p0, v1}, Lcom/aliyun/emas/apm/components/ComponentContainer;->setOf(Ljava/lang/Class;)Ljava/util/Set;

    move-result-object p0

    invoke-static {}, Lcom/aliyun/emas/apm/platforminfo/b;->a()Lcom/aliyun/emas/apm/platforminfo/b;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;-><init>(Ljava/util/Set;Lcom/aliyun/emas/apm/platforminfo/b;)V

    return-object v0
.end method

.method private static a(Ljava/util/Set;)Ljava/lang/String;
    .locals 4

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 2
    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    .line 3
    :cond_0
    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 4
    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    .line 5
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;->getLibraryName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x2f

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;->getVersion()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 6
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    const/16 v1, 0x20

    .line 7
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 10
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static component()Lcom/aliyun/emas/apm/components/Component;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/Component<",
            "Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;",
            ">;"
        }
    .end annotation

    .line 1
    const-class v0, Lcom/aliyun/emas/apm/platforminfo/UserAgentPublisher;

    invoke-static {v0}, Lcom/aliyun/emas/apm/components/Component;->builder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    .line 2
    const-class v1, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Dependency;->setOf(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher$$ExternalSyntheticLambda0;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher$$ExternalSyntheticLambda0;-><init>()V

    .line 3
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    .line 7
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public getUserAgent()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/platforminfo/b;->b()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a:Ljava/lang/String;

    return-object v0

    .line 5
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->b:Lcom/aliyun/emas/apm/platforminfo/b;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/platforminfo/b;->b()Ljava/util/Set;

    move-result-object v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/platforminfo/DefaultUserAgentPublisher;->a(Ljava/util/Set;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
