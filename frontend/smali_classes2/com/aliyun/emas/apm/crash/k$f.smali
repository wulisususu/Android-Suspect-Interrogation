.class Lcom/aliyun/emas/apm/crash/k$f;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/Thread;Ljava/lang/Throwable;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Throwable;

.field final synthetic b:Ljava/lang/Thread;

.field final synthetic c:J

.field final synthetic d:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/Throwable;Ljava/lang/Thread;J)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$f;->d:Lcom/aliyun/emas/apm/crash/k;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$f;->a:Ljava/lang/Throwable;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/k$f;->b:Ljava/lang/Thread;

    iput-wide p4, p0, Lcom/aliyun/emas/apm/crash/k$f;->c:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$f;->d:Lcom/aliyun/emas/apm/crash/k;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/k;->c()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$f;->d:Lcom/aliyun/emas/apm/crash/k;

    .line 2
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/k;)Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_0

    .line 4
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v0

    const-string v1, "Tried to write a non-fatal exception while no session was open."

    .line 5
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$f;->d:Lcom/aliyun/emas/apm/crash/k;

    .line 8
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/k;->c(Lcom/aliyun/emas/apm/crash/k;)Lcom/aliyun/emas/apm/crash/u0;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/k$f;->a:Ljava/lang/Throwable;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/k$f;->b:Ljava/lang/Thread;

    iget-wide v5, p0, Lcom/aliyun/emas/apm/crash/k$f;->c:J

    invoke-virtual/range {v1 .. v6}, Lcom/aliyun/emas/apm/crash/u0;->b(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;J)V

    :cond_1
    return-void
.end method
