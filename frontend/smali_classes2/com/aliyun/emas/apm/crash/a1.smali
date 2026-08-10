.class public Lcom/aliyun/emas/apm/crash/a1;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:Ljava/lang/String;

.field public final c:[Ljava/lang/StackTraceElement;

.field public final d:Lcom/aliyun/emas/apm/crash/a1;


# direct methods
.method private constructor <init>(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/StackTraceElement;Lcom/aliyun/emas/apm/crash/a1;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/a1;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/a1;->b:Ljava/lang/String;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/a1;->c:[Ljava/lang/StackTraceElement;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/a1;->d:Lcom/aliyun/emas/apm/crash/a1;

    return-void
.end method

.method public static a(Ljava/lang/Throwable;Lcom/aliyun/emas/apm/crash/y0;)Lcom/aliyun/emas/apm/crash/a1;
    .locals 5

    .line 1
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    :goto_0
    if-eqz p0, :cond_0

    .line 4
    invoke-virtual {v0, p0}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 5
    invoke-virtual {p0}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object p0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    .line 9
    :goto_1
    invoke-virtual {v0}, Ljava/util/AbstractCollection;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    .line 10
    invoke-virtual {v0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Throwable;

    .line 11
    new-instance v2, Lcom/aliyun/emas/apm/crash/a1;

    .line 13
    invoke-virtual {v1}, Ljava/lang/Throwable;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v3

    .line 14
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v4

    .line 15
    invoke-virtual {v1}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v1

    invoke-interface {p1, v1}, Lcom/aliyun/emas/apm/crash/y0;->a([Ljava/lang/StackTraceElement;)[Ljava/lang/StackTraceElement;

    move-result-object v1

    invoke-direct {v2, v3, v4, v1, p0}, Lcom/aliyun/emas/apm/crash/a1;-><init>(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/StackTraceElement;Lcom/aliyun/emas/apm/crash/a1;)V

    move-object p0, v2

    goto :goto_1

    :cond_1
    return-object p0
.end method
