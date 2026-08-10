.class public Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;
    }
.end annotation


# direct methods
.method public static synthetic $r8$lambda$vDAF1pey9okdEl85-C0aYIrHFuM(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    move-result-object p0

    return-object p0
.end method

.method private static synthetic a(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;Lcom/aliyun/emas/apm/components/ComponentContainer;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;
    .locals 1

    .line 1
    const-class v0, Landroid/content/Context;

    invoke-interface {p2, v0}, Lcom/aliyun/emas/apm/components/ComponentContainer;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Landroid/content/Context;

    invoke-interface {p1, p2}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;->a(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    move-result-object p0

    return-object p0
.end method

.method public static create(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/components/Component;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;"
        }
    .end annotation

    .line 1
    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    move-result-object p0

    const-class p1, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/components/Component;->intoSet(Ljava/lang/Object;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method

.method public static fromContext(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;)Lcom/aliyun/emas/apm/components/Component;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;",
            ")",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;"
        }
    .end annotation

    .line 1
    const-class v0, Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;

    invoke-static {v0}, Lcom/aliyun/emas/apm/components/Component;->intoSetBuilder(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    .line 2
    const-class v1, Landroid/content/Context;

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Dependency;->required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->add(Lcom/aliyun/emas/apm/components/Dependency;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/platforminfo/LibraryVersionComponent$a;)V

    .line 3
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object p0

    .line 4
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object p0

    return-object p0
.end method
