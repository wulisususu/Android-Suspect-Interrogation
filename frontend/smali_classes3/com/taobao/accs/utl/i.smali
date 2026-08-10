.class public Lcom/taobao/accs/utl/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/accs/utl/k$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/utl/i$a;,
        Lcom/taobao/accs/utl/i$c;,
        Lcom/taobao/accs/utl/i$b;
    }
.end annotation


# instance fields
.field private final a:[Lcom/taobao/accs/utl/i$c;

.field private final b:I

.field private final c:[Ljava/lang/String;

.field private final d:[J

.field private e:I


# direct methods
.method private constructor <init>()V
    .locals 6

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x5

    iput v0, p0, Lcom/taobao/accs/utl/i;->b:I

    new-array v1, v0, [Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/accs/utl/i;->c:[Ljava/lang/String;

    new-array v1, v0, [J

    iput-object v1, p0, Lcom/taobao/accs/utl/i;->d:[J

    const/4 v1, 0x0

    iput v1, p0, Lcom/taobao/accs/utl/i;->e:I

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_0

    iget-object v3, p0, Lcom/taobao/accs/utl/i;->c:[Ljava/lang/String;

    const/4 v4, 0x0

    .line 21
    aput-object v4, v3, v2

    iget-object v3, p0, Lcom/taobao/accs/utl/i;->d:[J

    const-wide/16 v4, 0x0

    .line 22
    aput-wide v4, v3, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x4

    new-array v0, v0, [Lcom/taobao/accs/utl/i$c;

    .line 24
    new-instance v2, Lcom/taobao/accs/utl/i$a;

    const-string v3, "send msg time out"

    invoke-direct {v2, v3}, Lcom/taobao/accs/utl/i$a;-><init>(Ljava/lang/String;)V

    aput-object v2, v0, v1

    new-instance v1, Lcom/taobao/accs/utl/i$a;

    const-string v2, "errorCode::"

    invoke-direct {v1, v2}, Lcom/taobao/accs/utl/i$a;-><init>(Ljava/lang/String;)V

    const/4 v2, 0x1

    aput-object v1, v0, v2

    new-instance v1, Lcom/taobao/accs/utl/i$a;

    const-string v2, "errorId::"

    invoke-direct {v1, v2}, Lcom/taobao/accs/utl/i$a;-><init>(Ljava/lang/String;)V

    const/4 v2, 0x2

    aput-object v1, v0, v2

    new-instance v1, Lcom/taobao/accs/utl/i$a;

    const-string v2, "TNET_JNI_ERR_LOAD_SO_FAIL"

    invoke-direct {v1, v2}, Lcom/taobao/accs/utl/i$a;-><init>(Ljava/lang/String;)V

    const/4 v2, 0x3

    aput-object v1, v0, v2

    iput-object v0, p0, Lcom/taobao/accs/utl/i;->a:[Lcom/taobao/accs/utl/i$c;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/accs/utl/j;)V
    .locals 0

    .line 3
    invoke-direct {p0}, Lcom/taobao/accs/utl/i;-><init>()V

    return-void
.end method

.method public static a()Lcom/taobao/accs/utl/i;
    .locals 1

    .line 16
    invoke-static {}, Lcom/taobao/accs/utl/i$b;->a()Lcom/taobao/accs/utl/i;

    move-result-object v0

    return-object v0
.end method

.method private a(Ljava/lang/String;[Lcom/taobao/accs/utl/i$c;)Z
    .locals 4

    .line 62
    array-length v0, p2

    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, v0, :cond_1

    aget-object v3, p2, v2

    .line 63
    invoke-interface {v3, p1}, Lcom/taobao/accs/utl/i$c;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return v1
.end method

.method private b(Ljava/lang/String;)V
    .locals 5

    iget v0, p0, Lcom/taobao/accs/utl/i;->e:I

    .line 55
    rem-int/lit8 v0, v0, 0x5

    iget-object v1, p0, Lcom/taobao/accs/utl/i;->c:[Ljava/lang/String;

    .line 56
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v2, " #$%"

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, v0

    iget-object p1, p0, Lcom/taobao/accs/utl/i;->d:[J

    .line 1071
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const-wide/16 v3, 0x3e8

    div-long/2addr v1, v3

    .line 57
    aput-wide v1, p1, v0

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/accs/utl/i;->e:I

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/utl/i;->a:[Lcom/taobao/accs/utl/i$c;

    .line 46
    invoke-direct {p0, p1, v0}, Lcom/taobao/accs/utl/i;->a(Ljava/lang/String;[Lcom/taobao/accs/utl/i$c;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 47
    invoke-direct {p0, p1}, Lcom/taobao/accs/utl/i;->b(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 50
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    :goto_0
    return-void
.end method

.method public b()Ljava/lang/String;
    .locals 9

    .line 75
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 2071
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const-wide/16 v3, 0x3e8

    div-long/2addr v1, v3

    .line 76
    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :try_start_0
    iget v1, p0, Lcom/taobao/accs/utl/i;->e:I

    add-int/lit8 v1, v1, -0x1

    const/4 v3, 0x5

    .line 78
    rem-int/2addr v1, v3

    add-int/2addr v1, v3

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_0

    sub-int v5, v1, v4

    .line 80
    rem-int/2addr v5, v3

    iget-object v6, p0, Lcom/taobao/accs/utl/i;->c:[Ljava/lang/String;

    .line 81
    aget-object v6, v6, v5

    if-eqz v6, :cond_0

    iget-object v6, p0, Lcom/taobao/accs/utl/i;->d:[J

    .line 82
    aget-wide v7, v6, v5

    invoke-virtual {v0, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/taobao/accs/utl/i;->c:[Ljava/lang/String;

    aget-object v5, v7, v5

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catchall_0
    move-exception v1

    .line 88
    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    .line 90
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
