.class public Lcom/ta/utdid2/a/a/a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/ta/utdid2/a/a/a$b;,
        Lcom/ta/utdid2/a/a/a$a;
    }
.end annotation


# static fields
.field static final synthetic d:Z = true


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 739
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static encode([BI)[B
    .locals 2

    const/4 v0, 0x0

    .line 486
    array-length v1, p0

    invoke-static {p0, v0, v1, p1}, Lcom/ta/utdid2/a/a/a;->encode([BIII)[B

    move-result-object p0

    return-object p0
.end method

.method public static encode([BIII)[B
    .locals 5

    .line 501
    new-instance v0, Lcom/ta/utdid2/a/a/a$b;

    const/4 v1, 0x0

    invoke-direct {v0, p3, v1}, Lcom/ta/utdid2/a/a/a$b;-><init>(I[B)V

    .line 504
    div-int/lit8 p3, p2, 0x3

    mul-int/lit8 p3, p3, 0x4

    .line 507
    iget-boolean v1, v0, Lcom/ta/utdid2/a/a/a$b;->e:Z

    const/4 v2, 0x2

    const/4 v3, 0x1

    if-eqz v1, :cond_0

    .line 508
    rem-int/lit8 v1, p2, 0x3

    if-lez v1, :cond_3

    add-int/lit8 p3, p3, 0x4

    goto :goto_0

    .line 512
    :cond_0
    rem-int/lit8 v1, p2, 0x3

    if-eq v1, v3, :cond_2

    if-eq v1, v2, :cond_1

    goto :goto_0

    :cond_1
    add-int/lit8 p3, p3, 0x3

    goto :goto_0

    :cond_2
    add-int/lit8 p3, p3, 0x2

    .line 525
    :cond_3
    :goto_0
    iget-boolean v1, v0, Lcom/ta/utdid2/a/a/a$b;->f:Z

    if-eqz v1, :cond_5

    if-lez p2, :cond_5

    add-int/lit8 v1, p2, -0x1

    .line 526
    div-int/lit8 v1, v1, 0x39

    add-int/2addr v1, v3

    iget-boolean v4, v0, Lcom/ta/utdid2/a/a/a$b;->g:Z

    if-eqz v4, :cond_4

    goto :goto_1

    :cond_4
    move v2, v3

    :goto_1
    mul-int/2addr v1, v2

    add-int/2addr p3, v1

    .line 530
    :cond_5
    new-array v1, p3, [B

    iput-object v1, v0, Lcom/ta/utdid2/a/a/a$b;->a:[B

    .line 531
    invoke-virtual {v0, p0, p1, p2, v3}, Lcom/ta/utdid2/a/a/a$b;->a([BIIZ)Z

    sget-boolean p0, Lcom/ta/utdid2/a/a/a;->d:Z

    if-nez p0, :cond_7

    .line 533
    iget p0, v0, Lcom/ta/utdid2/a/a/a$b;->b:I

    if-ne p0, p3, :cond_6

    goto :goto_2

    :cond_6
    new-instance p0, Ljava/lang/AssertionError;

    invoke-direct {p0}, Ljava/lang/AssertionError;-><init>()V

    throw p0

    .line 535
    :cond_7
    :goto_2
    iget-object p0, v0, Lcom/ta/utdid2/a/a/a$b;->a:[B

    return-object p0
.end method

.method public static encodeToString([BI)Ljava/lang/String;
    .locals 1

    .line 450
    :try_start_0
    new-instance v0, Ljava/lang/String;

    invoke-static {p0, p1}, Lcom/ta/utdid2/a/a/a;->encode([BI)[B

    move-result-object p0

    const-string p1, "US-ASCII"

    invoke-direct {v0, p0, p1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception p0

    .line 453
    new-instance p1, Ljava/lang/AssertionError;

    invoke-direct {p1, p0}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw p1
.end method
