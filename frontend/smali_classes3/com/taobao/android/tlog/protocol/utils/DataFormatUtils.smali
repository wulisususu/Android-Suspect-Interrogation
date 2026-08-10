.class public Lcom/taobao/android/tlog/protocol/utils/DataFormatUtils;
.super Ljava/lang/Object;
.source "DataFormatUtils.java"


# static fields
.field public static final BYTES_COUNT_INT:B = 0x4t


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static int2Bytes(I)[B
    .locals 3

    const/4 v0, 0x4

    new-array v0, v0, [B

    const/4 v1, 0x0

    int-to-byte v2, p0

    aput-byte v2, v0, v1

    shr-int/lit8 v1, p0, 0x8

    int-to-byte v1, v1

    const/4 v2, 0x1

    aput-byte v1, v0, v2

    shr-int/lit8 v1, p0, 0x10

    int-to-byte v1, v1

    const/4 v2, 0x2

    aput-byte v1, v0, v2

    shr-int/lit8 p0, p0, 0x18

    int-to-byte p0, p0

    const/4 v1, 0x3

    aput-byte p0, v0, v1

    return-object v0
.end method

.method public static varargs merge([[B)[B
    .locals 6

    const/4 v0, 0x0

    move v1, v0

    move v2, v1

    .line 31
    :goto_0
    array-length v3, p0

    if-ge v1, v3, :cond_0

    .line 32
    aget-object v3, p0, v1

    array-length v3, v3

    add-int/2addr v2, v3

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 34
    :cond_0
    new-array v1, v2, [B

    move v2, v0

    move v3, v2

    .line 36
    :goto_1
    array-length v4, p0

    if-ge v2, v4, :cond_1

    .line 37
    aget-object v4, p0, v2

    array-length v5, v4

    invoke-static {v4, v0, v1, v3, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 38
    aget-object v4, p0, v2

    array-length v4, v4

    add-int/2addr v3, v4

    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    :cond_1
    return-object v1
.end method
