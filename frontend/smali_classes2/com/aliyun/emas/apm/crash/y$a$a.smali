.class Lcom/aliyun/emas/apm/crash/y$a$a;
.super Lcom/aliyun/emas/apm/crash/e;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/y$a;->newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Runnable;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/y$a;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/y$a;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/y$a$a;->b:Lcom/aliyun/emas/apm/crash/y$a;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/y$a$a;->a:Ljava/lang/Runnable;

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/y$a$a;->a:Ljava/lang/Runnable;

    .line 1
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    return-void
.end method
