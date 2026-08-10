.class Lcom/aliyun/emas/apm/crash/k$e;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(JLjava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;JLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$e;->c:Lcom/aliyun/emas/apm/crash/k;

    iput-wide p2, p0, Lcom/aliyun/emas/apm/crash/k$e;->a:J

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/k$e;->b:Ljava/lang/String;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Void;
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$e;->c:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/k;->c()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$e;->c:Lcom/aliyun/emas/apm/crash/k;

    .line 2
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->f(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/e0;

    move-result-object v0

    iget-wide v1, p0, Lcom/aliyun/emas/apm/crash/k$e;->a:J

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k$e;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2, v3}, Lcom/aliyun/emas/apm/crash/e0;->a(JLjava/lang/String;)V

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/k$e;->a()Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method
