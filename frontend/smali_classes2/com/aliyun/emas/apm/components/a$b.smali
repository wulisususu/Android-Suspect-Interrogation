.class public Lcom/aliyun/emas/apm/components/a$b;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/components/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "b"
.end annotation


# instance fields
.field public final a:Lcom/aliyun/emas/apm/components/Component;

.field public final b:Ljava/util/Set;

.field public final c:Ljava/util/Set;


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/components/Component;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->b:Ljava/util/Set;

    .line 3
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->c:Ljava/util/Set;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/a$b;->a:Lcom/aliyun/emas/apm/components/Component;

    return-void
.end method


# virtual methods
.method public a()Lcom/aliyun/emas/apm/components/Component;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->a:Lcom/aliyun/emas/apm/components/Component;

    return-object v0
.end method

.method public a(Lcom/aliyun/emas/apm/components/a$b;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->b:Ljava/util/Set;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public b()Ljava/util/Set;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->b:Ljava/util/Set;

    return-object v0
.end method

.method public b(Lcom/aliyun/emas/apm/components/a$b;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->c:Ljava/util/Set;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public c(Lcom/aliyun/emas/apm/components/a$b;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->c:Ljava/util/Set;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    return-void
.end method

.method public c()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->b:Ljava/util/Set;

    .line 2
    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    return v0
.end method

.method public d()Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$b;->c:Ljava/util/Set;

    .line 1
    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    return v0
.end method
