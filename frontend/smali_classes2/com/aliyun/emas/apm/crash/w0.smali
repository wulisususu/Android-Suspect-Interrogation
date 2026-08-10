.class public Lcom/aliyun/emas/apm/crash/w0;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/x0;


# instance fields
.field private final a:Ljava/util/concurrent/atomic/AtomicReference;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/t;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/w0;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 5
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/w;->a(Lcom/aliyun/emas/apm/crash/t;)Lcom/aliyun/emas/apm/crash/v0;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    return-void
.end method

.method public static a()Lcom/aliyun/emas/apm/crash/w0;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/z0;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/z0;-><init>()V

    .line 2
    new-instance v1, Lcom/aliyun/emas/apm/crash/w0;

    invoke-direct {v1, v0}, Lcom/aliyun/emas/apm/crash/w0;-><init>(Lcom/aliyun/emas/apm/crash/t;)V

    return-object v1
.end method


# virtual methods
.method public getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/w0;->a:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/v0;

    return-object v0
.end method
